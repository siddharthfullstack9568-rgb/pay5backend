// app/javascript/controllers/modal_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["transactionChart", "revenueChart"]

  connect() {
    console.log("dashboard connteddddd");
    this.renderTransactionChart()
    this.renderRevenueChart()
  }

  renderTransactionChart() {
    const ctx = this.transactionChartTarget.getContext("2d")

    new Chart(ctx, {
      type: "bar",
      data: {
        labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun"],
        datasets: [
          {
            label: "Transactions",
            data: [50, 70, 40, 80, 60, 90],
            backgroundColor: "rgba(59, 130, 246, 0.5)",
          },
          {
            label: "Revenue",
            data: [1000, 2000, 1500, 3000, 2500, 4000],
            type: "line",
            borderColor: "orange",
            yAxisID: "y1",
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          y: { beginAtZero: true },
          y1: { beginAtZero: true, position: "right" },
        },
      },
    })
  }

  renderRevenueChart() {
    const ctx2 = this.revenueChartTarget.getContext("2d")

    new Chart(ctx2, {
      type: "pie",
      data: {
        labels: [
          "Commerce & Cloud Services",
          "Payment & financial services",
        ],
        datasets: [
          {
            data: [25, 75],
            backgroundColor: ["orange", "blue"],
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
      },
    })
  }
}
