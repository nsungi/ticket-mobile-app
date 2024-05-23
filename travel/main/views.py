
from rest_framework.generics import ListCreateAPIView, RetrieveUpdateDestroyAPIView
from rest_framework import generics, status
from rest_framework.response import Response
from django.contrib.auth import authenticate
from rest_framework_simplejwt.tokens import RefreshToken
from . models import User, Payment, Ticket, TicketSalesReport
from .serializers import RegisterSerializer, LoginSerializer, UserSerializer, TicketSalesReportSerializer, PaymentSerializer, TicketSerializer
from io import BytesIO
from django.core.files.storage import FileSystemStorage
from reportlab.pdfgen import canvas
from rest_framework.views import APIView
from rest_framework.generics import CreateAPIView
from .utils import generate_ticket_pdf
from django.http import HttpResponse 



# authentication

class RegisterView(generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = RegisterSerializer
    


class LoginView(generics.GenericAPIView):
    serializer_class = LoginSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        username = serializer.validated_data['username']
        password = serializer.validated_data['password']
        user = authenticate(username=username, password=password)
        
        if user is not None:
            refresh = RefreshToken.for_user(user)
            return Response({
                'refresh': str(refresh),
                'access': str(refresh.access_token),
            })
        return Response({"detail": "Invalid credentials"}, status=status.HTTP_401_UNAUTHORIZED)




# Ticket

class TicketCreateAPIView(generics.CreateAPIView):
    queryset = Ticket.objects.all()
    serializer_class = TicketSerializer
    


class TicketListCreateView(ListCreateAPIView):
    queryset = Ticket.objects.all()
    serializer_class = TicketSerializer
    
    
class TicketRetrieveUpdateDestroyView(RetrieveUpdateDestroyAPIView):
    queryset = Ticket.objects.all()
    serializer_class = TicketSerializer
        


 
# Download ticket    
class TicketDownloadView(APIView):
    def get(self, request, ticket_id):
        try:
            ticket = Ticket.objects.get(id=ticket_id)
            if ticket.pdf_filename:
                storage = FileSystemStorage()
                try:
                    with storage.open(ticket.pdf_filename, 'rb') as f:
                        pdf_data = f.read()
                        response = HttpResponse(pdf_data, content_type='application/pdf')
                        response['Content-Disposition'] = f'attachment; filename="{ticket.pdf_filename}"'
                        return response
                except FileNotFoundError:
                    return Response({'error': 'PDF file not found'}, status=404)
            else:
                return Response({'error': 'No PDF generated for this ticket'}, status=404)
        except Ticket.DoesNotExist:
            return Response({'error': 'Ticket not found'}, status=404)




#making payment
class PaymentCreateView(CreateAPIView):
    queryset = Payment.objects.all()
    serializer_class = PaymentSerializer

    def perform_create(self, serializer):
        ticket = serializer.validated_data['ticket']
        fare_amount = serializer.validated_data['fare_amount']

        payment = serializer.save(is_paid=True)
        pdf_data = generate_ticket_pdf(ticket)
        filename = f"ticket_{ticket.id}.pdf"
        storage = FileSystemStorage()
        with storage.open(filename, 'wb') as f:
            f.write(pdf_data)

        ticket.pdf_filename = filename
        ticket.save()
  



class PaymentDetailView(generics.RetrieveAPIView):
    queryset = Payment.objects.all()
    serializer_class = PaymentSerializer
    
    
  

# generating sales report
class TicketSalesReportAPIView(generics.ListAPIView):
    serializer_class = TicketSalesReportSerializer

    def get_queryset(self):
        time_period = self.request.query_params.get('time_period', 'daily')
        TicketSalesReport.generate_sales_report(time_period)  # Trigger report generation
        return TicketSalesReport.objects.filter(time_period=time_period)
