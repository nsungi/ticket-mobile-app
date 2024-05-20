# Generated by Django 4.2.10 on 2024-05-18 12:10

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("main", "0001_initial"),
    ]

    operations = [
        migrations.CreateModel(
            name="TicketSalesReport",
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
                ("travel_class", models.CharField(max_length=20)),
                ("route", models.CharField(max_length=255)),
                (
                    "time_period",
                    models.CharField(
                        choices=[
                            ("daily", "Daily"),
                            ("weekly", "Weekly"),
                            ("monthly", "Monthly"),
                        ],
                        max_length=10,
                    ),
                ),
                ("start_date", models.DateField()),
                ("end_date", models.DateField()),
                (
                    "total_sales",
                    models.DecimalField(decimal_places=2, default=0, max_digits=10),
                ),
            ],
        ),
        migrations.DeleteModel(
            name="DailySalesReport",
        ),
    ]