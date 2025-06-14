module DeliveriesHelper
  def delivery_status_badge_class(status)
    if status.preparing?
      'bg-secondary'
    elsif status.shipped?
      'bg-warning text-dark'
    elsif status.delivered?
      'bg-primary'
    end
  end
end
