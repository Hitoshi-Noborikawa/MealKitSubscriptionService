module DeliveriesHelper
  def delivery_status_badge_class(status)
    case status.to_s
    when 'delivered'
      'bg-primary'
    when 'shipping'
      'bg-warning text-dark'
    when 'pending'
      'bg-secondary'
    else
      'bg-light text-dark'
    end
  end
end
