from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin
from django.contrib.auth.models import Group

from .models import (
    User,
    Ticket,
    Payment,
   TicketSalesReport,
 
)

class CustomUserAdmin(BaseUserAdmin):
    model = User
    list_display = ['username', 'phone_number', 'is_staff', 'is_active']
    fieldsets = (
        (None, {'fields': ('username', 'phone_number', 'password')}),
        ('Permissions', {'fields': ('is_staff', 'is_superuser', 'groups', 'user_permissions')}),
    )
    add_fieldsets = (
        (None, {'fields': ('username', 'phone_number', 'password1', 'password2')}),
    )


admin.site.register(User, CustomUserAdmin)
admin.site.unregister(Group)  # Unregister default Group model
admin.site.register(Ticket)
admin.site.register(Payment)
admin.site.register(TicketSalesReport)
 
