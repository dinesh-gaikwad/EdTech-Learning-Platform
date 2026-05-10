from .models import (
    AIRecommendation,
    LearningPrediction
)

from .recommendation_engine import (
    RecommendationEngine
)

from .prediction_engine import (
    PredictionEngine
)


class AIService:

    @staticmethod
    def generate_user_recommendations(
        user
    ):

        recommendations = (
            RecommendationEngine.generate_recommendations(
                user
            )
        )

        saved = []

        for item in recommendations:

            rec = AIRecommendation.objects.create(
                user=user,
                recommended_course=item['course'],
                recommendation_score=item['score']
            )

            saved.append(rec)

        return saved

    @staticmethod
    def generate_prediction(user):

        completion_rate = (
            PredictionEngine.predict_completion()
        )

        predicted_score = (
            PredictionEngine.predict_exam_score()
        )

        prediction = LearningPrediction.objects.create(
            user=user,
            predicted_completion_rate=completion_rate,
            predicted_score=predicted_score
        )

        return prediction
