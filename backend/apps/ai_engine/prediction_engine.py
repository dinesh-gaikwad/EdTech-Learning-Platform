import random


class PredictionEngine:

    @staticmethod
    def predict_completion():

        return round(
            random.uniform(60, 100),
            2
        )

    @staticmethod
    def predict_exam_score():

        return round(
            random.uniform(70, 99),
            2
        )
