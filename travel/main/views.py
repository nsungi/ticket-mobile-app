

from rest_framework.generics import ListCreateAPIView, RetrieveUpdateDestroyAPIView
from rest_framework import generics, status, permissions
from rest_framework.response import Response
from django.contrib.auth import authenticate
from rest_framework.views import APIView
from rest_framework import viewsets
from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from django.utils import timezone
from .utils import Utils
import qrcode
from django.contrib import messages
from . models import User, Payment, Ticket, TicketSalesReport
from .serializers import (  UserRegistrationSerializer,   UserDetailsSerializer, TicketSalesReportSerializer,
                          PaymentSerializer, TicketSerializer,  )
                          
                          


 
from rest_framework.authtoken.models import Token
from rest_framework.exceptions import AuthenticationFailed
 
from django.db.utils import IntegrityError
from .serializers import UserLoginSerializer, UserDetailsSerializer
from io import BytesIO
from django.core.files.storage import FileSystemStorage
from reportlab.pdfgen import canvas
from qrcode import QRCode
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.generics import CreateAPIView

from .utils import generate_ticket_pdf
import json
import os
import tempfile

  
from django.http import HttpResponse 
 
 

import logging
 
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.authtoken.models import Token
from rest_framework.exceptions import ValidationError

from django.db.utils import IntegrityError

logger = logging.getLogger(__name__)


class UserRegistrationAPIView(generics.GenericAPIView):
    serializer_class = UserRegistrationSerializer

    def post(self, request):
        serializer = self.serializer_class(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)



class LoginView(generics.GenericAPIView):
    serializer_class = UserLoginSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        username = serializer.validated_data['username']
        password = serializer.validated_data['password']

        user = authenticate(username=username, password=password)
        if user is not None:
            try:
                token, created = Token.objects.get_or_create(user=user)
                return Response({'token': token.key}, status=status.HTTP_200_OK)
            except IntegrityError:
                return Response({"error": "Token creation failed due to database integrity error."}, status=status.HTTP_400_BAD_REQUEST)
        else:
            raise AuthenticationFailed('Invalid username or password.')
        
        
"""
class UserDetailsView(generics.RetrieveAPIView):
    serializer_class = UserDetailsSerializer
    queryset = User.objects.all()

    def get_object(self):
        return self.request.user
"""

class GetUserDetailsAPIView(generics.GenericAPIView):
    serializer_class = UserDetailsSerializer
    permission_classes = [IsAuthenticated]

    def get(self, request):
        serializer = self.serializer_class(request.user)
        return Response(serializer.data, status=status.HTTP_200_OK)

 


class TicketCreateAPIView(generics.CreateAPIView):
    queryset = Ticket.objects.all()
    serializer_class = TicketSerializer
    


class TicketListCreateView(ListCreateAPIView):
    queryset = Ticket.objects.all()
    serializer_class = TicketSerializer
    
    
    
    
class TicketRetrieveUpdateDestroyView(RetrieveUpdateDestroyAPIView):
    queryset = Ticket.objects.all()
    serializer_class = TicketSerializer
        





"""
class PaymentCreateView(generics.CreateAPIView):
    queryset = Payment.objects.all()
    serializer_class = PaymentSerializer
  #  permission_classes = [permissions.IsAuthenticated]  
  
"""  

class PaymentDetailView(generics.RetrieveAPIView):
    queryset = Payment.objects.all()
    serializer_class = PaymentSerializer
   # permission_classes = [permissions.IsAuthenticated]   




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

 
 
 

class TicketSalesReportAPIView(generics.ListAPIView):
    serializer_class = TicketSalesReportSerializer

    def get_queryset(self):
        time_period = self.request.query_params.get('time_period', 'daily')
        return TicketSalesReport.objects.filter(time_period=time_period)


 # sales report be seen by admin uncomment below
"""
from django.contrib.auth.decorators import user_passes_test
from rest_framework import generics
from .models import TicketSalesReport
from .serializers import TicketSalesReportSerializer

# Custom user passes test function to check if the user is admin or superuser
def is_admin_or_superuser(user):
    return user.is_superuser or user.is_staff

class TicketSalesReportAPIView(generics.ListAPIView):
    serializer_class = TicketSalesReportSerializer

    # Apply the user_passes_test decorator to restrict access to admin or superuser
    @user_passes_test(is_admin_or_superuser)
    def get_queryset(self):
        time_period = self.request.query_params.get('time_period', 'daily')
        return TicketSalesReport.objects.filter(time_period=time_period)

"""

