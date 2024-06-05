from django.urls import path
from rest_framework.routers import DefaultRouter
from . import views
from .views import (
    TicketSalesReportAPIView,
    PaymentCreateView, PaymentDetailView,
    TicketDownloadView,
    RegisterView, LoginView,
    TicketListCreateView, TicketRetrieveUpdateDestroyView,
    TicketCreateAPIView, TicketCancellationAPIView,
    validate_and_redirect
)

router = DefaultRouter()

urlpatterns = [
    path('register/', RegisterView.as_view(), name='register'),
    path('login/', LoginView.as_view(), name='login'),
    
    path('tickets/create/', TicketCreateAPIView.as_view(), name='ticket-create'),
    path('tickets/', TicketListCreateView.as_view(), name='ticket-list-create'),
    path('tickets/<int:pk>/', TicketRetrieveUpdateDestroyView.as_view(), name='ticket-retrieve-update-destroy'),
     
     
    path('tickets/<int:pk>/cancel/', TicketCancellationAPIView.as_view(), name='ticket-cancel'),

    
    # Payment
    path('payments/create/', PaymentCreateView.as_view(), name='payment-create'),
    path('payments/<int:pk>/', PaymentDetailView.as_view(), name='payment-detail'),
    
    path('validate-ticket/', validate_and_redirect, name='validate-ticket'),
    
    path('tickets/<int:ticket_id>/download/', TicketDownloadView.as_view(), name='ticket-download'),
    
    path('sales-reports/', TicketSalesReportAPIView.as_view(), name='ticket-sales-report'),
]

urlpatterns += router.urls  # Add router URLs to urlpatterns



 