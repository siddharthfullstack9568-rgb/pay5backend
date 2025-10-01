class Superadmin::TravelAndStayReportController < ApplicationController

 def travel_report
  @instant_Loans = InstantLoan.all
 end

end