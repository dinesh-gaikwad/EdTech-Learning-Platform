from celery import shared_task

from .services import NotificationService


@shared_task
def send_bulk_email(
    users,
    subject,
    body
):

    for user in users:

        NotificationService.send_email_notification(
            user,
            subject,
            body
        )

    return True
