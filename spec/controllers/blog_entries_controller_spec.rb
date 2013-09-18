require 'spec_helper'

describe BlogEntriesController do

  context "#index" do
    it "paginates blog entries" do
      blog_entries = []
      BlogEntry.stub_chain(:newest,:with_content,:paginate).
        with(page: '2', per_page: 5).and_return(blog_entries)

      BlogEntry.stub_chain(:newest,:we_are_reading,:limit).and_return([])

      get :index, page: 2

      expect(assigns(:blog_entries)).to eq blog_entries
      expect(response).to be_successful
    end

    it "includes we_are_reading blog entries" do
      BlogEntry.stub_chain(:newest,:with_content,:paginate).and_return([])

      blog_entries = 'blog entries'
      BlogEntry.stub_chain(:newest,:we_are_reading,:limit).and_return(blog_entries)

      get :index, page: 2
      expect(assigns(:we_are_reading)).to eq blog_entries
      expect(response).to be_successful
    end
  end

  context "#show" do
    it "loads a blog entry by ID" do
      blog_entry = double("Blog entry")
      BlogEntry.should_receive(:find).with('42').and_return(blog_entry)

      get :show, id: 42

      expect(assigns(:blog_entry)).to eq blog_entry
      expect(response).to be_successful
    end
  end
end
