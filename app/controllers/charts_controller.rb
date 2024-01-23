class ChartsController < ApplicationController
  def chart_data
    render json: { time: Time.now.to_i, value: rand(1..28) }
  end

  def chart_view
    const chart = new Chart(context, {
        type: 'line',
        data: {
          labels: [],
          datasets: [{
            label: 'Animation Progress',
            data: [],
            borderColor: 'orange',
            borderWidth: 2,
            legend: {
              display: false,
            }
          }],
        },
        options: {
          scales: {
            x: {
              type: 'linear',
              position: 'bottom',
              title: {
                display: false,
                text: 'Time',
              },
            },
            y: {
              type: 'linear',
              position: 'left',
              title: {
                display: false,
                text: 'Value',
              },
              beginAtZero: false, // Do not start y-axis from zero
            },
          },
        },
      });

      

      function drawGraph() {
        const currentTime = Date.now();
        if (!animationStartTime) {
          animationStartTime = currentTime;
        }
        const elapsedTime = currentTime - animationStartTime;

        const progress = Math.min(1, elapsedTime / animationDuration);
        const value = 1 + progress * (elapsedTime / 1000);

        chart.data.labels.push((elapsedTime / 1000).toFixed(2));
        chart.data.datasets[0].data.push(value);
        chart.update();

        valueDisplay.textContent = `Stake* ${value.toFixed(2)}`;

        if (elapsedTime >= randomStopTime || (progress >= 1 && animationIsRunning)) {
          stopAnimation(value);
        } else  (animationIsRunning) {
          requestAnimationFrame(drawGraph);
        }
      }
  end
end
