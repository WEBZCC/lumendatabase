# frozen_string_literal: true

class PrivateInformation < Notice
  def self.model_name
    Notice.model_name
  end

  def to_partial_path
    'notices/notice'
  end
end
