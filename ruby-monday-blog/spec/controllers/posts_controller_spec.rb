require "rails_helper"

describe PostsController do
  it "doesn't create a new tag if it already exists" do
    params = {
      post: {
        body:  'lorem',
        title: 'ipsum',
        tags_attributes: [{ content: 'Ruby' }]
      }
    }

    expect { post :create, params }
      .to change{ Tag.count }.by (1)

    expect { post :create, params }
      .to_not change{ Tag.count }
  end
end
