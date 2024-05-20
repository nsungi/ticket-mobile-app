

from django_cron import CronJobBase, Schedule
from .models import TicketSalesReport

class GenerateSalesReportCronJob(CronJobBase):
    RUN_AT_TIMES = ['00:00']  # Runs daily at midnight

    schedule = Schedule(run_at_times=RUN_AT_TIMES)
    code = 'main.generate_sales_report'  # Unique code for the cron job

    def do(self):
        TicketSalesReport.generate_sales_report()
