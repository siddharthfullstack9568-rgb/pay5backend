class Superadmin::TravelAndStayReportController < Superadmin::BaseController

 def travel_report
  @instant_Loans = InstantLoan.all
 end

end