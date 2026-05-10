class LearningPipeline:

    @staticmethod
    def unlock_next_lesson(progress):

        if progress >= 80:
            return True

        return False

    @staticmethod
    def calculate_progress(total_lessons, completed_lessons):

        if total_lessons == 0:
            return 0

        return (completed_lessons / total_lessons) * 100
