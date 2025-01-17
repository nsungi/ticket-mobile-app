# Generated by Django 4.2.10 on 2024-06-04 05:56

from django.db import migrations, models
import django.db.models.deletion
import main.models


class Migration(migrations.Migration):
    dependencies = [
        ("main", "0007_alter_user_managers_alter_user_groups_and_more"),
    ]

    operations = [
        migrations.CreateModel(
            name="Seat",
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
                    "number",
                    models.CharField(
                        choices=[
                            ("B1", "B1"),
                            ("B2", "B2"),
                            ("B3", "B3"),
                            ("B4", "B4"),
                            ("B5", "B5"),
                            ("B6", "B6"),
                            ("S1", "S1"),
                            ("S2", "S2"),
                            ("S3", "S3"),
                            ("S4", "S4"),
                            ("S5", "S5"),
                            ("S6", "S6"),
                            ("E1", "E1"),
                            ("E2", "E2"),
                            ("E3", "E3"),
                            ("E4", "E4"),
                            ("E5", "E5"),
                            ("E6", "E6"),
                        ],
                        max_length=5,
                        unique=True,
                    ),
                ),
                (
                    "seat_class",
                    models.CharField(
                        choices=[
                            ("Economy", "Economy"),
                            ("Standard", "Standard"),
                            ("Business", "Business"),
                        ],
                        max_length=10,
                    ),
                ),
                ("is_booked", models.BooleanField(default=False)),
                (
                    "color",
                    models.CharField(
                        choices=[("#FFFFFF", "White"), ("#FF0000", "Red")],
                        default="#FFFFFF",
                        max_length=7,
                    ),
                ),
            ],
        ),
        migrations.RemoveField(
            model_name="ticket",
            name="seat_number",
        ),
        migrations.AlterField(
            model_name="ticket",
            name="route",
            field=models.CharField(
                blank=True,
                choices=[
                    ("From Dar to Moro", "From Dar to Moro"),
                    ("From Dar to Charinze", "From Dar to Charinze"),
                    ("From Moro to Charinze", "From Moro to Charinze"),
                    ("From Moro to Dar", "From Moro to Dar"),
                ],
                max_length=255,
                null=True,
            ),
        ),
        migrations.AlterField(
            model_name="ticket",
            name="serial_number",
            field=models.CharField(
                default=main.models.generate_short_serial,
                editable=False,
                max_length=12,
                unique=True,
            ),
        ),
        migrations.AlterField(
            model_name="ticket",
            name="travel_class",
            field=models.CharField(
                choices=[
                    ("Economy", "Economy"),
                    ("Standard", "Standard"),
                    ("Business", "Business"),
                ],
                max_length=10,
            ),
        ),
        migrations.AddField(
            model_name="ticket",
            name="seat",
            field=models.OneToOneField(
                default=1, on_delete=django.db.models.deletion.CASCADE, to="main.seat"
            ),
        ),
    ]
