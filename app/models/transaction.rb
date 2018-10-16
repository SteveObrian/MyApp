class Transaction < ApplicationRecord
  TRANSACTION_TYPES = %w[withdraw deposit].freeze
  PURPOSES = %w[rent food restaurant fun sport depts other].freeze
  belongs_to :account

  validates :account, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :transaction_type, presence: true, inclusion: { in: TRANSACTION_TYPES }
  validates :transaction_number, presence: true, uniqueness: true
  validates :purpose, presence: true, inclusion: { in: PURPOSES }, if: -> { withdraw? }

  before_validation :load_defaults

  scope :expenses_for_this_month, -> {
    where(transaction_type: 'withdraw')
      .where('created_at >= ? AND created_at <= ?', Date.today.beginning_of_month, Time.now)
  }
  scope :all_expenses, -> { where(transaction_type: 'withdraw') }
  scope :expenses_for, ->(purpose) { where(purpose: purpose).pluck(:amount) }

  def withdraw?
    return true if transaction_type == 'withdraw'
  end

  private

  def load_defaults
    return unless new_record?
    self.transaction_number = SecureRandom.uuid
  end
end
