

from rest_framework import serializers
from .models import User, Payment, Ticket, TicketSalesReport
from django.utils import timezone
from django.contrib.auth import get_user_model
from django.contrib.auth.password_validation import validate_password


User = get_user_model()

#authentication

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'username', 'phone_number')
        
        
        

class RegisterSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True, required=True, validators=[validate_password])
    password2 = serializers.CharField(write_only=True, required=True)

    class Meta:
        model = User
        fields = ('username', 'phone_number', 'password', 'password2')

    def validate(self, attrs):
        if attrs['password'] != attrs['password2']:
            raise serializers.ValidationError({"password": "Password fields didn't match."})
        return attrs

    def create(self, validated_data):
        user = User.objects.create(
            username=validated_data['username'],
            phone_number=validated_data['phone_number']
        )
        user.set_password(validated_data['password'])
        user.save()
        return user
    
    
    

class LoginSerializer(serializers.Serializer):
    username = serializers.CharField(required=True)
    password = serializers.CharField(required=True, write_only=True)



# ticket

class TicketSerializer(serializers.ModelSerializer):
    class Meta:
        model = Ticket
        fields = ['id', 'serial_number', 'passenger', 'passenger_phone_number', 'gender', 'fare_amount', 'travel_class', 'seat_number', 'booking_date', 'travel_date', 'expiry_date', 'route']
        read_only_fields = ['serial_number', 'fare_amount', 'booking_date', 'expiry_date']

    def validate_travel_date(self, value):
        """
        Ensure that the travel date is not in the past.
        """
        if value < timezone.now().date():
            raise serializers.ValidationError("Travel date cannot be in the past.")
        return value

    def validate(self, data):
        """
        Ensure that the expiry date is set to travel date + 2 days.
        Set fare_amount based on travel_class.
        """
        travel_date = data.get('travel_date')

        if travel_date:
            expiry_date = travel_date + timezone.timedelta(days=2)
            data['expiry_date'] = expiry_date

        travel_class = data.get('travel_class')

        if travel_class:
            if travel_class == 'Economy':
                data['fare_amount'] = 100.00
            elif travel_class == 'Business':
                data['fare_amount'] = 200.00
            elif travel_class == 'First Class':
                data['fare_amount'] = 300.00

        return data



# making payment

class PaymentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Payment
        fields = ['id', 'ticket', 'fare_amount', 'payment_method', 'payment_date', 'is_paid']
        read_only_fields = ['payment_date', 'is_paid']

    def validate_fare_amount(self, value):
        """
        Ensure that the fare amount matches the fare amount of the ticket.
        """
        ticket = self.initial_data.get('ticket')
        if ticket:
            ticket_instance = Ticket.objects.get(id=ticket)
            if value != ticket_instance.fare_amount:
                raise serializers.ValidationError("The fare amount does not match the ticket fare amount.")
        return value

    def create(self, validated_data):
        ticket = validated_data['ticket']
        validated_data['fare_amount'] = ticket.fare_amount
        return super().create(validated_data)





# generating sales report

class TicketSalesReportSerializer(serializers.ModelSerializer):
    class Meta:
        model = TicketSalesReport
        fields = '__all__'

