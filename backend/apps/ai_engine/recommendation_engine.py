import random


class RecommendationEngine:

    @staticmethod
    def generate_recommendations(user):

        sample_courses = [

            'Advanced Python',
            'Django Mastery',
            'React.js Bootcamp',
            'Machine Learning',
            'Docker & Kubernetes'
        ]

        recommendations = []

        for course in sample_courses:

            recommendations.append({

                'course': course,

                'score': round(
                    random.uniform(0.5, 0.99),
                    2
                )
            })

        return recommendations
