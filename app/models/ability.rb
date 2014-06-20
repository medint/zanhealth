class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
      if user.role.name == "bmet_tech"
       	  can :manage, [BmetCost, BmetItemHistory, BmetLaborHour, BmetNeed, BmetWorkOrderComment]
          can [:read, :create, :update], [BmetWorkOrder,BmetWorkRequest,BmetItem,BmetModel,Part,PartTransaction]
          can [:hidden, :all, :show_all, :show_hidden, :set_users, :set_departments, :set_status,:as_csv,:search], [BmetWorkOrder, BmetWorkRequest,BmetPreventativeMaintenance]
          can [:set_hidden_bmet_work_orders, :set_all_bmet_work_orders, :set_bmet_work_order, :show_print], BmetWorkOrder 
          can [:set_hidden_bmet_work_requests, :set_all_bmet_work_requests], BmetWorkRequest
          can [:read, :create, :set_hidden_bmet_preventative_maintenance, :set_all_bmet_preventative_maintenance], BmetPreventativeMaintenance
          can [:read, :set_status, :wo_finances, :statusAjax, :status], :bmet_dashboard 
          can [:as_csv], BmetItem
          cannot [:delete,:hide], [BmetItem, BmetWorkOrder,BmetWorkRequest,BmetPreventativeMaintenance, BmetModel, Part,PartTransaction] 
          cannot :manage, :registration
          cannot :manage, :admin  
          cannot :manage, :settings
          cannot :labor_hours, user
	  elsif user.role.name == "fac_tech"
	  	  can :manage, [FacilityCost, FacilityLaborHour, FacilityWorkOrderComment]
	  	  can [:read, :create, :update], [FacilityWorkOrder, FacilityWorkRequest,Part,PartTransaction]
	  	  can [:hidden, :all, :show_all, :show_hidden, :set_users, :set_departments, :set_status,:as_csv,:search], [FacilityWorkOrder,FacilityWorkRequest, FacilityPreventativeMaintenance]
	  	  can [:set_hidden_facility_work_orders, :set_all_facility_work_orders], FacilityWorkOrder
	  	  can [:set_hidden_facility_work_requests, :set_all_facility_work_requests], FacilityWorkRequest
	  	  can [:read, :create, :set_hidden_facility_preventative_maintenance, :set_all_facility_preventative_maintenance], FacilityPreventativeMaintenance
          can [:read, :set_status, :wo_finances, :statusAjax, :status], :facility_dashboard 
	  	  cannot [:destroy, :hide], [FacilityWorkOrder,FacilityWorkRequest,FacilityPreventativeMaintenance,Part,PartTransaction]
	  	  cannot :manage, :registration
        cannot :manage, :admin
        cannot :manage, :settings
	  	  cannot :labor_hours, user
	  elsif user.role.name == "bmet_fac_tech"
	  	  can :manage, [FacilityCost, FacilityLaborHour, FacilityWorkOrderComment, BmetCost, BmetLaborHour, BmetWorkOrderComment,BmetItemHistory,BmetNeed]
	  	  can [:read, :create, :update], [BmetWorkOrder, FacilityWorkOrder,BmetWorkRequest, FacilityWorkRequest,BmetItem,BmetModel,Part,PartTransaction]
	  	  can [:hidden, :all, :show_all, :show_hidden, :set_users, :set_departments, :set_status, :as_csv, :search], [BmetWorkOrder, FacilityWorkOrder,BmetWorkRequest, FacilityWorkRequest, BmetPreventativeMaintenance, FacilityPreventativeMaintenance]
        can [:as_csv], BmetItem
	  	  can [:set_hidden_facility_work_orders, :set_all_facility_work_orders], FacilityWorkOrder
     	  can [:set_hidden_bmet_work_orders, :set_all_bmet_work_orders], BmetWorkOrder 
     	  can [:set_hidden_facility_work_requests, :set_all_facility_work_requests], FacilityWorkRequest
     	  can [:set_hidden_bmet_work_requests, :set_all_bmet_work_requests], BmetWorkRequest
     	  can [:read, :create, :set_hidden_bmet_preventative_maintenance, :set_all_bmet_preventative_maintenance, :set_hidden_facility_preventative_maintenance, :set_all_facility_preventative_maintenance], [BmetPreventativeMaintenance, FacilityPreventativeMaintenance]
        can [:read, :set_status, :wo_finances, :statusAjax, :status], [:facility_dashboard, :bmet_dashboard]
	  	  cannot [:destroy, :hide], [BmetWorkOrder, FacilityWorkOrder, BmetWorkRequest, FacilityWorkRequest, BmetPreventativeMaintenance, FacilityPreventativeMaintenance,BmetItem, BmetModel,Part, PartTransaction]
	  	  cannot :manage, :registration
        cannot :manage, :admin
        cannot :manage, :settings
	  	  cannot :labor_hours, user 
	  elsif user.role.name == "chief"
	  	  can :manage, :all
	  	  can :labor_hours, user
	  	  cannot :delete, [BmetWorkOrder,FacilityWorkOrder,BmetPreventativeMaintenance,FacilityPreventativeMaintenance]
	  	  cannot :manage, :registration
        cannot :manage, :admin
	  elsif user.role.name == "admin"
	  	  can :labor_hours, user
	  	  can :manage, [:all, :bmet_dashboard, :facility_dashboard, :registration]
	  end
  end
end
