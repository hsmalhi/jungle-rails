class Admin::DashboardController < Admin::BaseController
  def show
    @productCount = Product.count
    @categoryCount = Category.count
    puts @productCount
    puts @categoryCount
    puts "here"
  end
end
