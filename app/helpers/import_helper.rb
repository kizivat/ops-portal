module ImportHelper
  def convert_timestamp_value(value)
    Time.at(value).to_datetime
  end
end
