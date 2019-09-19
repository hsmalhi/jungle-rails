class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["ADMIN_USERNAME"], password: ENV["ADMIN_PASSWORD"]

  def show
    @productCount = Product.count
    @categoryCount = Category.count
    puts @productCount
    puts @categoryCount
    puts "here"
  end
end
