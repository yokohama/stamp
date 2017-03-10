class Decision < ApplicationRecord
  extend Enumerize

  belongs_to :submit
  belongs_to :proposal

  enumerize :decision, in: %i(none ok ng), default: :none

  enumerize :decision_label, in: {
    none: 'label-default', 
    ok: 'label-info', 
    ng: 'label-danger'
  }

  # enumlizeで定義されているdecision毎のカウントメソッドを定義
  class << self
    Decision.decision.values.each do |d_value|
      define_method("count_#{d_value.to_s}") do |proposal_id|
        self.where(proposal_id: proposal_id, decision: d_value).count
      end

      define_method("users_#{d_value.to_s}") do |proposal_id|
        #TODO
      end
    end
  end
end
