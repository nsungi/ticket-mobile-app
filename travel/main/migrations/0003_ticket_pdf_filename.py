# Generated by Django 4.2.10 on 2024-05-19 16:11

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("main", "0002_ticketsalesreport_delete_dailysalesreport"),
    ]

    operations = [
        migrations.AddField(
            model_name="ticket",
            name="pdf_filename",
            field=models.CharField(blank=True, max_length=255, null=True),
        ),
    ]
