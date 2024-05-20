

from django.urls import path
from rest_framework.routers import DefaultRouter


 
from rest_framework_simplejwt.views import TokenVerifyView
from rest_framework_simplejwt.views import TokenRefreshView
from . import views

 
from .views import (
    TicketSalesReportAPIView,
    PaymentCreateView, PaymentDetailView,
    PaymentCreateView, TicketDownloadView,
    LoginView,
    
)

from .views import TicketListCreateView, TicketRetrieveUpdateDestroyView

router = DefaultRouter()
 
 
urlpatterns = [

    path('register/', views.UserRegistrationAPIView.as_view()),
     
    path('login/', LoginView.as_view(), name='login'),

    path('tickets/create/', views.TicketCreateAPIView.as_view(), name='ticket-create'),
    #path('tickets/', views.TicketCreateAPIView.as_view(), name='ticket_create'), to be removed
    
    
    path('tickets/', TicketListCreateView.as_view(), name='ticket-list-create'),
    path('tickets/<int:pk>/', TicketRetrieveUpdateDestroyView.as_view(), name='ticket-retrieve-update-destroy'),
    

    path('user-details/', views.GetUserDetailsAPIView.as_view()),
    path('verify-token/', TokenVerifyView.as_view()),
    path('token/refresh/', TokenRefreshView.as_view()),
    
    
    #payment
    path('payments/create/', PaymentCreateView.as_view(), name='payment-create'),
    path('payments/<int:pk>/', PaymentDetailView.as_view(), name='payment-detail'),
    
    
    path('payments/create/', PaymentCreateView.as_view(), name='payment-create'),
    path('tickets/<int:ticket_id>/download/', TicketDownloadView.as_view(), name='ticket-download'),
    
    
    path('ticket-sales/', TicketSalesReportAPIView.as_view(), name='ticket_sales_report'),
 

] 

urlpatterns += router.urls  # Add router URLs to urlpatterns



  