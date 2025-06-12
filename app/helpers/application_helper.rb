module ApplicationHelper
  def bootstrap_class_for_status(status)
    case status.to_s.downcase
    when 'pending'
      'bg-warning text-dark'    # jaune
    when 'confirmed', 'paid'
      'bg-success'              # vert
    when 'cancelled', 'refunded'
      'bg-danger'               # rouge
    when 'shipped'
      'bg-info text-dark'       # bleu clair
    else
      'bg-secondary'            # gris neutre par défaut
    end
  end
end
