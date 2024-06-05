

from django.contrib.auth.models import AbstractUser, Group, Permission
from django.db import models
from django.db.models import Sum
import datetime
from datetime import datetime, timedelta
from django.utils import timezone
import uuid


 
#Authentication
 
class User(AbstractUser):
    username = models.CharField(max_length=150, unique=True)
    phone_number = models.CharField(max_length=20, unique=True)

    USERNAME_FIELD = 'username'
    REQUIRED_FIELDS = ['phone_number']

    def __str__(self):
        return self.username
 
 


# Ticket

import uuid
import base64
from django.db import models
from datetime import timedelta

def generate_short_serial():
    # Generate a UUID and then convert it to a shorter base36 string
    u = uuid.uuid4()
    return base64.urlsafe_b64encode(u.bytes).rstrip(b'=').decode('ascii')[:6]


class Ticket(models.Model):
    GENDER_CHOICES = [
        ('M', 'Male'),
        ('F', 'Female'),
    ]

    CLASS_CHOICES = [
        ('Economy', 'Economy'),
        ('Standard', 'Standard'),
        ('Business', 'Business'),
    ]

    ROUTE_CHOICES = [
        ('From Dar to Moro', 'From Dar to Moro'),
        ('From Dar to Charinze', 'From Dar to Charinze'),
        ('From Moro to Charinze', 'From Moro to Charinze'),
        ('From Moro to Dar', 'From Moro to Dar'),
    ]

    SEAT_CLASSES = [
        ('Economy', 'Economy'),
        ('Standard', 'Standard'),
        ('Business', 'Business'),
    ]

    SEAT_NUMBERS = [
        ('B1', 'B1'), ('B2', 'B2'), ('B3', 'B3'),
        ('B4', 'B4'), ('B5', 'B5'), ('B6', 'B6'),
        ('S1', 'S1'), ('S2', 'S2'), ('S3', 'S3'),
        ('S4', 'S4'), ('S5', 'S5'), ('S6', 'S6'),
        ('E1', 'E1'), ('E2', 'E2'), ('E3', 'E3'),
        ('E4', 'E4'), ('E5', 'E5'), ('E6', 'E6'),
    ]

    serial_number = models.CharField(max_length=12, unique=True, default=generate_short_serial, editable=False)
    passenger = models.CharField(max_length=255)
    passenger_phone_number = models.CharField(max_length=20, blank=True, null=True)
    gender = models.CharField(max_length=1, choices=GENDER_CHOICES)
    fare_amount = models.DecimalField(max_digits=10, decimal_places=2, editable=False)
    travel_class = models.CharField(max_length=10, choices=CLASS_CHOICES)
    seat_number = models.CharField(max_length=5, choices=SEAT_NUMBERS)  # Seat number
    seat_class = models.CharField(max_length=10, choices=SEAT_CLASSES)  # Seat class
    is_seat_booked = models.BooleanField(default=False)  # Seat booking status
    booking_date = models.DateField(auto_now_add=True)
    travel_date = models.DateField()
    expiry_date = models.DateField(null=True, blank=True)
    route = models.CharField(max_length=255, choices=ROUTE_CHOICES, null=True, blank=True)
    qr_code = models.BinaryField(null=True, blank=True)
    pdf_filename = models.CharField(max_length=255, null=True, blank=True)

    def __str__(self):
        return f"Ticket {self.serial_number} for {self.passenger}"

    def save(self, *args, **kwargs):
        # Set fare_amount based on travel_class
        if self.travel_class == 'Economy':
            self.fare_amount = 100.00
        elif self.travel_class == 'Standard':
            self.fare_amount = 200.00
        elif self.travel_class == 'Business':
            self.fare_amount = 300.00

        # Set expiry_date to 30 minutes after travel_date
        self.expiry_date = self.travel_date + timedelta(minutes=30)

        super().save(*args, **kwargs)




#payment

class Payment(models.Model):
    PAYMENT_METHOD_CHOICES = [
        ('Cash', 'Cash'),
        ('Card', 'Card'),
    ]

    ticket = models.OneToOneField(Ticket, on_delete=models.CASCADE, related_name='payment')
    fare_amount = models.DecimalField(max_digits=10, decimal_places=2)
    payment_date = models.DateField(auto_now_add=True)
    payment_method = models.CharField(max_length=10, choices=PAYMENT_METHOD_CHOICES, default='Cash')
    is_paid = models.BooleanField(default=False)

    def __str__(self):
        return f"Payment for Ticket {self.ticket.serial_number} on {self.payment_date}"


 
# Ticket
 
class TicketSalesReport(models.Model):
    TIME_PERIOD_CHOICES = [
        ('daily', 'Daily'),
        ('weekly', 'Weekly'),
        ('monthly', 'Monthly'),
    ]

    travel_class = models.CharField(max_length=20)
    route = models.CharField(max_length=255)
    time_period = models.CharField(max_length=10, choices=TIME_PERIOD_CHOICES)
    start_date = models.DateField()
    end_date = models.DateField()
    total_sales = models.DecimalField(max_digits=10, decimal_places=2, default=0)

    def __str__(self):
        return f"{self.time_period} Sales Report - Class: {self.travel_class}, Route: {self.route}"

    @classmethod
    def generate_sales_report(cls, time_period):
        today = datetime.now().date()
        
        if time_period == 'monthly':
            start_date = today.replace(day=1) - timedelta(days=1)
            start_date = start_date.replace(day=1)
            end_date = today
        elif time_period == 'weekly':
            start_date = today - timedelta(days=today.weekday() + 7)
            end_date = today
        else:  # daily
            start_date = today
            end_date = today

        sales_reports = []
        for travel_class in Ticket.CLASS_CHOICES:
            for route in Ticket.ROUTE_CHOICES:
                total_sales = Ticket.objects.filter(
                    booking_date__gte=start_date,
                    booking_date__lte=end_date,
                    travel_class=travel_class[0],
                    route=route[0]
                ).aggregate(total_sales=Sum('fare_amount'))['total_sales'] or 0

                sales_report, _ = cls.objects.get_or_create(
                    time_period=time_period,
                    start_date=start_date,
                    end_date=end_date,
                    travel_class=travel_class[0],
                    route=route[0]
                )
                sales_report.total_sales = total_sales
                sales_report.save()
                sales_reports.append(sales_report)

        return sales_reports