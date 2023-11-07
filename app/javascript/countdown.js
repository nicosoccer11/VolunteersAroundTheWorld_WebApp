window.onload = function() {
    console.log('DOMContentLoaded event fired.');
    const finalCountdownDateElement = document.querySelector('.countdown');
    const days = document.querySelector('.days')
    const daysElement = document.querySelector('.days');
    const hoursElement = document.querySelector('.hours');
    const minutesElement = document.querySelector('.minutes');
  
    if (finalCountdownDateElement.dataset.finalCountdownDate !== "" ) {
        const finalCountdownDate = new Date(finalCountdownDateElement.dataset.finalCountdownDate);
        countDownClock(finalCountdownDate, daysElement, hoursElement, minutesElement);
    } else {
        // Handle the case when there is no final countdown event
        daysElement.textContent = '00';
        hoursElement.textContent = '00';
        minutesElement.textContent = '00';
    }
}

function countDownClock(finalCountdownDate, daysElement, hoursElement, minutesElement) {
    let countdown;
    timer(finalCountdownDate);

    function timer(finalCountdownDate) {
        countdown = setInterval(() => {
            const now = new Date().getTime();
            const targetDate = finalCountdownDate.getTime();
            const timeLeft = targetDate - now;

            if (timeLeft <= 0) {
                clearInterval(countdown);
                return;
            }
            displayTimeLeft(timeLeft);
        }, 1000);
    }

    function displayTimeLeft(milliseconds) {
        const totalSeconds = Math.floor(milliseconds / 1000);
        const totalMinutes = Math.floor(totalSeconds / 60);
        const totalHours = Math.floor(totalMinutes / 60);

        daysElement.textContent = String(Math.floor(totalHours / 24)).padStart(2, '0');
        hoursElement.textContent = String(totalHours % 24).padStart(2, '0');
        minutesElement.textContent = String(totalMinutes % 60).padStart(2, '0');
    }
}