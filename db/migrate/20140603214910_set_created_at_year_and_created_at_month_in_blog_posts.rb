class SetCreatedAtYearAndCreatedAtMonthInBlogPosts < ActiveRecord::Migration
  def change
    BlogPost.all.each do |blog_post|
      blog_post.set_created_at_month_and_year
      blog_post.save
    end
  end
end
