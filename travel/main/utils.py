from rest_framework_simplejwt.tokens import RefreshToken
from reportlab.pdfgen import canvas
from reportlab.lib.colors import blue, green, red, black
from io import BytesIO
from qrcode import QRCode
import json
import tempfile
import os

class Utils:
    @staticmethod
    def get_tokens_for_user(user):
        refresh = RefreshToken.for_user(user)
        return {
            'refresh': str(refresh),
            'access': str(refresh.access_token)
        }

def generate_ticket_pdf(ticket):
    qr_code_data = {
        'serial_number': str(ticket.serial_number),
        'passenger_phone_number': ticket.passenger_phone_number,
        'payment_method': ticket.payment.payment_method,
        'fare_amount': str(ticket.payment.fare_amount),
        'expiry_date': ticket.expiry_date.strftime('%Y-%m-%d'),
    }

    qr_code = QRCode(version=1, box_size=2, border=1)
    qr_code.add_data(json.dumps(qr_code_data))
    qr_code.make(fit=True)
    qr_code_img = qr_code.make_image(fill_color="black", back_color="white")

    buffer = BytesIO()
    pdf = canvas.Canvas(buffer, pagesize=(50, 20))

    # Add the title
    pdf.setFont("Times-Roman", 3)
    pdf.setFillColor(blue)
    pdf.drawCentredString(25, 18, "E-Ticketing System")

    # Arrange the items within the ticket
    pdf.setFont("Times-Roman", 1.5)
    pdf.setFillColor(black)
    pdf.drawString(3, 15, f"Passenger: {ticket.passenger}")
    pdf.setFillColor(green)
    pdf.drawString(3, 13, f"Route: {ticket.route}")
    pdf.setFillColor(red)
    pdf.drawString(3, 11, f"Travel Class: {ticket.travel_class}")
    pdf.setFillColor(black)
    pdf.drawString(3, 9, f"Seat Number: {ticket.seat_number}")
    pdf.setFillColor(blue)
    pdf.drawString(3, 7, f"Gender: {ticket.get_gender_display()}")

    # Adjust the position and size of the QR code
    with tempfile.NamedTemporaryFile(suffix=".png", delete=False) as temp_file:
        qr_code_img.save(temp_file, format="PNG")
        qr_code_image_path = temp_file.name

    pdf.drawImage(qr_code_image_path, 35, 5, width=10, height=10)

    pdf.showPage()
    pdf.save()

    buffer.seek(0)
    pdf_data = buffer.getvalue()

    os.remove(qr_code_image_path)

    return pdf_data
