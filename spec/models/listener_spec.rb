require 'rails_helper'

RSpec.describe Listener, type: :model do
  describe '#matches_query?' do
    context "no match" do
      it "works for AND clauses" do
        query = 'hello|world'
        content = 'hello this beautiful'
        expect(Listener.matches_query?(content, query)).to be false
      end

      it "works for OR clauses" do
        query = 'hi,world'
        content = 'hello chris'
        expect(Listener.matches_query?(content, query)).to be false
      end
      
      it "works for AND / OR clauses" do
        query = 'hello|chriss,world' # This is ambiguous
        content = 'hello chris'
        expect(Listener.matches_query?(content, query)).to be false
      end
    end

    context "match" do
      it 'case insensitive matches' do
        query = 'hello|world'
        content = 'Hello this beautiful World'
        expect(Listener.matches_query?(content, query)).to be_truthy
      end

      it "works for AND clauses" do
        query = 'hello|world'
        content = 'hello this beautiful world'
        expect(Listener.matches_query?(content, query)).to be_truthy
      end

      it "works for OR clauses" do
        query = 'hello,world'
        content = 'hello chris'
        expect(Listener.matches_query?(content, query)).to be_truthy
      end
      
      it "works for AND / OR clauses" do
        query = 'hello|chris,world' # This is ambiguous
        content = 'hello chris'
        expect(Listener.matches_query?(content, query)).to be_truthy
      end
    end
  end
end
