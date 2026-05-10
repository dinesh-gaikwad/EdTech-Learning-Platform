from reportlab.pdfgen import canvas


def generate_pdf(path, student_name, course_name):

    c = canvas.Canvas(path)

    c.setFont("Helvetica-Bold", 28)

    c.drawString(
        100,
        750,
        "Certificate of Completion"
    )

    c.setFont("Helvetica", 18)

    c.drawString(
        100,
        680,
        f"Presented to: {student_name}"
    )

    c.drawString(
        100,
        640,
        f"For completing: {course_name}"
    )

    c.save()
