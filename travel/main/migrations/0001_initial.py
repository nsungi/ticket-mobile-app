# Generated by Django 4.2.10 on 2024-05-17 18:32

from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone
import uuid


class Migration(migrations.Migration):
    initial = True

    dependencies = [
        ("auth", "0012_alter_user_first_name_max_length"),
    ]

    operations = [
        migrations.CreateModel(
            name="DailySalesReport",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("date", models.DateField(unique=True)),
                ("total_tickets_sold", models.PositiveIntegerField()),
                ("total_revenue", models.DecimalField(decimal_places=2, max_digits=10)),
            ],
        ),
        migrations.CreateModel(
            name="Ticket",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                (
                    "serial_number",
                    models.UUIDField(default=uuid.uuid4, editable=False, unique=True),
                ),
                ("passenger", models.CharField(max_length=255)),
                (
                    "passenger_phone_number",
                    models.CharField(blank=True, max_length=20, null=True),
                ),
                (
                    "gender",
                    models.CharField(
                        choices=[("M", "Male"), ("F", "Female")], max_length=1
                    ),
                ),
                (
                    "fare_amount",
                    models.DecimalField(
                        decimal_places=2, editable=False, max_digits=10
                    ),
                ),
                (
                    "travel_class",
                    models.CharField(
                        choices=[
                            ("Economy", "Economy"),
                            ("Business", "Business"),
                            ("First Class", "First Class"),
                        ],
                        max_length=20,
                    ),
                ),
                (
                    "seat_number",
                    models.CharField(
                        choices=[
                            ("A1", "A1"),
                            ("B2", "B2"),
                            ("C2", "C2"),
                            ("D2", "D2"),
                            ("E2", "E2"),
                        ],
                        max_length=10,
                    ),
                ),
                ("booking_date", models.DateField(auto_now_add=True)),
                ("travel_date", models.DateField()),
                ("expiry_date", models.DateField(blank=True, null=True)),
                (
                    "route",
                    models.CharField(
                        blank=True,
                        choices=[
                            ("From Mbeya to Kigoma", "From Mbeya to Kigoma"),
                            ("From Mbeya to Dar", "From Mbeya to Dar"),
                            ("From Dar to Mwanza", "From Dar to Mwanza"),
                            ("From Dar to Kigoma", "From Dar to Kigoma"),
                        ],
                        max_length=255,
                        null=True,
                    ),
                ),
                ("qr_code", models.BinaryField(blank=True, null=True)),
            ],
        ),
        migrations.CreateModel(
            name="ValidationGate",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("location", models.CharField(max_length=50)),
                ("QR_code_scanned", models.CharField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name="User",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("password", models.CharField(max_length=128, verbose_name="password")),
                (
                    "last_login",
                    models.DateTimeField(
                        blank=True, null=True, verbose_name="last login"
                    ),
                ),
                (
                    "is_superuser",
                    models.BooleanField(
                        default=False,
                        help_text="Designates that this user has all permissions without explicitly assigning them.",
                        verbose_name="superuser status",
                    ),
                ),
                (
                    "first_name",
                    models.CharField(
                        blank=True, max_length=150, verbose_name="first name"
                    ),
                ),
                (
                    "last_name",
                    models.CharField(
                        blank=True, max_length=150, verbose_name="last name"
                    ),
                ),
                (
                    "email",
                    models.EmailField(
                        blank=True, max_length=254, verbose_name="email address"
                    ),
                ),
                (
                    "is_staff",
                    models.BooleanField(
                        default=False,
                        help_text="Designates whether the user can log into this admin site.",
                        verbose_name="staff status",
                    ),
                ),
                (
                    "is_active",
                    models.BooleanField(
                        default=True,
                        help_text="Designates whether this user should be treated as active. Unselect this instead of deleting accounts.",
                        verbose_name="active",
                    ),
                ),
                (
                    "date_joined",
                    models.DateTimeField(
                        default=django.utils.timezone.now, verbose_name="date joined"
                    ),
                ),
                ("username", models.CharField(max_length=150, unique=True)),
                ("phone_number", models.CharField(max_length=20, unique=True)),
                (
                    "groups",
                    models.ManyToManyField(
                        related_name="custom_user_groups", to="auth.group"
                    ),
                ),
                (
                    "user_permissions",
                    models.ManyToManyField(
                        related_name="custom_user_permissions", to="auth.permission"
                    ),
                ),
            ],
            options={
                "verbose_name": "user",
                "verbose_name_plural": "users",
                "abstract": False,
            },
        ),
        migrations.CreateModel(
            name="Payment",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("fare_amount", models.DecimalField(decimal_places=2, max_digits=10)),
                ("payment_date", models.DateField(auto_now_add=True)),
                (
                    "payment_method",
                    models.CharField(
                        choices=[("Cash", "Cash"), ("Card", "Card")],
                        default="cash",
                        max_length=10,
                    ),
                ),
                ("is_paid", models.BooleanField(default=False)),
                (
                    "ticket",
                    models.OneToOneField(
                        default=1,
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="payment",
                        to="main.ticket",
                    ),
                ),
            ],
        ),
        migrations.CreateModel(
            name="BookingHistory",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("booking_date", models.DateTimeField(auto_now_add=True)),
                ("modification_date", models.DateTimeField(auto_now=True)),
                ("cancellation_date", models.DateTimeField(blank=True, null=True)),
                (
                    "ticket",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE, to="main.ticket"
                    ),
                ),
                (
                    "user",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="booking_history",
                        to="main.user",
                    ),
                ),
            ],
        ),
        migrations.CreateModel(
            name="Administrator",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("dashboard_access", models.BooleanField(default=True)),
                (
                    "user",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="administrators",
                        to="main.user",
                    ),
                ),
            ],
        ),
    ]
