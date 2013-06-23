# encoding: UTF-8
shared_examples_for :authentication_required do
  context :not_logged_in do
    before do
      do_action 
    end

    it { should redirect_to(root_url) }
    it { flash[:notice].should == "Você precisa estar autenticado..." }
  end
end