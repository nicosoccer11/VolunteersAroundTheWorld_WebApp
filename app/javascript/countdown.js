// countdown.js

document.addEventListener("DOMContentLoaded", function() {
    const finalCountdownDateElement = document.querySelector('.countdown');

    if (finalCountdownDateElement) {
        const finalCountdownDate = new Date(finalCountdownDateElement.dataset.finalCountdownDate);
        const daysElement = document.querySelector('.days');
        const hoursElement = document.querySelector('.hours');
        const minutesElement = document.querySelector('.minutes');

        countDownClock(finalCountdownDate, daysElement, hoursElement, minutesElement);
    }
});

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

        daysElement.textContent = Math.floor(totalHours / 24);
        hoursElement.textContent = totalHours % 24;
        minutesElement.textContent = totalMinutes % 60;
    }

}