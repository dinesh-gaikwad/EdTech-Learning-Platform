# /workspaces/EdTech-Learning-Platform/backend/apps/accounts/utils.py

import random
import string
from datetime import datetime


def generate_username(name):

    random_digits = ''.join(
        random.choices(
            string.digits,
            k=4
        )
    )

    username = (
        f"{name.lower().replace(' ', '')}"
        f"{random_digits}"
    )

    return username


def calculate_profile_completion(user):

    profile_fields = [

        user.first_name,
        user.last_name,
        user.bio,
        user.github_url,
        user.linkedin_url,
        user.portfolio_url,
        user.country,
        user.city,
        user.profile_picture,
    ]

    completed_fields = sum(
        bool(field)
        for field in profile_fields
    )

    percentage = int(
        (completed_fields / len(profile_fields)) * 100
    )

    return percentage


def generate_referral_code():

    return ''.join(
        random.choices(
            string.ascii_uppercase + string.digits,
            k=8
        )
    )


def current_year():

    return datetime.now().year


def user_rank(points):

    if points >= 5000:
        return 'Legend'

    if points >= 3000:
        return 'Master'

    if points >= 1500:
        return 'Advanced'

    if points >= 500:
        return 'Intermediate'

    return 'Beginner'