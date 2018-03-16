json.extract! review, :body, :created_at, :updated_at
json.url review_url(question, format: :json)
