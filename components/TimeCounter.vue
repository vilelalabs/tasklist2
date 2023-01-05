<template>
    <p>{{ timerOutput }}</p>
</template>

<script>
import { computed } from 'vue'

export default {
    name: 'TimeCounter',
    data() {
        return {
            timerInSeconds: 0,
            interval: null,
        }
    },
    props: {
        state: {
            type: String,
            required: true,
        }
    },
    methods: {
        startTimer() {
            this.interval = setInterval(() => {
                this.timerInSeconds++
            }, 1000)
        },
        stopTimer() {
            clearInterval(this.interval)
        },
    },
    watch: {
        state() {
            if (this.state === 'playing') {
                this.startTimer()
            } else {
                this.stopTimer()
            }
        }
    },
    computed: {
        timerOutput() {
            const hours = (Math.floor(this.timerInSeconds / 3600)).toString().padStart(2, '0')
            const minutes = (Math.floor((this.timerInSeconds % 3600) / 60)).toString().padStart(2, '0')
            const formattedSeconds = (this.timerInSeconds % 60).toString().padStart(2, '0')
            return `${hours}:${minutes}:${formattedSeconds}`;
        }
    }
}
</script>

<style scoped>

</style>