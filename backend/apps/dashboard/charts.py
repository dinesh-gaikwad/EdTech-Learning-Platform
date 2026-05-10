def generate_learning_chart(data):

    labels = []
    values = []

    for item in data:

        labels.append(item['label'])

        values.append(item['value'])

    return {
        'labels': labels,
        'values': values
    }
