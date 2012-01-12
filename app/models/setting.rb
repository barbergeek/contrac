class Setting < ActiveRecord::Base
  
  def self.method_missing(method, *args, &block)
    return self.send method, *args, &block if self.respond_to? method
    method_name = method.to_s
    if method_name =~ /=/
      return self.set method_name.gsub("=", ""), args.first
    else
      return self.get method_name
    end
  end
  
  def self.get setting
    entry = Setting.where(:key => setting).first
    entry.nil? ? nil : YAML.load(entry.value)
  end
  
  def self.set key, value
    setting = Setting.where(:key => key).first || Setting.new(:key => key)
    setting.update_attribute(:value, value.to_yaml)
  end
  
end

# == Schema Information
#
# Table name: settings
#
#  id         :integer         not null, primary key
#  key        :string(255)
#  value      :text
#  created_at :datetime
#  updated_at :datetime
#

