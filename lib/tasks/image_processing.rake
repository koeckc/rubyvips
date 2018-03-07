namespace :viennarb do
  desc 'shrink image with vips'
  task shrink_vips: :environment do
    im = Vips::Image.new_from_file "#{Rails.root}/test/medium_plan.jpg"
    #im = Vips::Image.new_from_file "#{Rails.root}/test/big_plan.jpg"
    resizedim = im.resize 0.5
    resizedim.write_to_file "#{Rails.root}/test/processed.jpg"
  end

  desc 'shrink image with rmagick'
  task shrink_magick: :environment do
    img = Magick::Image.read("#{Rails.root}/test/medium_plan.jpg").first    
    #img = Magick::Image.read("#{Rails.root}/test/big_plan.jpg").first    
    img.resize! 0.5        
    img.write "#{Rails.root}/test/processed.jpg"
  end
end
