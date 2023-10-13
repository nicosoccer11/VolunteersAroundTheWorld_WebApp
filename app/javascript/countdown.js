// countdown.js

document.addEventListener("DOMContentLoaded", function() {
    const finalCountdownDateElement = document.querySelector('.countdown');
    console.log("finalCountdownDateElement", finalCountdownDateElement);

    if (finalCountdownDateElement) {
        const finalCountdownDate = new Date(finalCountdownDateElement.dataset.finalCountdownDate);
        const daysElement = document.querySelector('.days');
        const hoursElement = document.querySelector('.hours');
        const minutesElement = document.querySelector('.minutes');
        console.log("finalCountdownDate", finalCountdownDate);
        console.log("daysElement", daysElement);
        console.log("hoursElement", hoursElement);
        console.log("minutesElement", minutesElement);

        countDownClock(finalCountdownDate, daysElement, hoursElement, minutesElement);
    }
});

function countDownClock(finalCountdownDate, daysElement, hoursElement, minutesElement) {
    let countdown;
    console.log("calling time function")
    timer(finalCountdownDate);

    function timer(finalCountdownDate) {
        console.log("INSIDE TIMER FUNCTION")
        countdown = setInterval(() => {
            const now = new Date().getTime();
            const targetDate = finalCountdownDate.getTime();
            console.log("targetDate", targetDate)
            const timeLeft = targetDate - now;
            console.log("timeLeft", timeLeft)

            if (timeLeft <= 0) {
                clearInterval(countdown);
                return;
            }
            console.log("Calling DISPLAYTIME function")
            displayTimeLeft(timeLeft);
        }, 1000);
    }

    function displayTimeLeft(milliseconds) {
        const totalSeconds = Math.floor(milliseconds / 1000);
        const totalMinutes = Math.floor(totalSeconds / 60);
        const totalHours = Math.floor(totalMinutes / 60);
        console.log("CHANGING TEXTCONTENT")
        console.log(totalMinutes)
        daysElement.textContent = Math.floor(totalHours / 24);
        hoursElement.textContent = totalHours % 24;
        minutesElement.textContent = totalMinutes % 60;
    }
    console.log("countdown", countdown);
}

