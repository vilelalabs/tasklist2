<template>
    <p>{{ timerOutput }}</p>
</template>

<script>
export default {
    name: 'TimeCounter',
    data() {
        return {
            timer: this.timerInSeconds,
            interval: null,
        }
    },
    props: {
        state: {
            type: String,
            required: true,
        },
        timerInSeconds: {
            type: Number,
            required: true,
            default: 0,
        }
    },
    methods: {
        startTimer() {
            this.interval = setInterval(() => {
                this.timer++
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
            const hours = (Math.floor(this.timer / 3600)).toString().padStart(2, '0')
            const minutes = (Math.floor((this.timer % 3600) / 60)).toString().padStart(2, '0')
            const formattedSeconds = (this.timer % 60).toString().padStart(2, '0')
            this.$emit('timer-output', this.timer)
            return `${hours}:${minutes}:${formattedSeconds}`;
        }
    }
}
</script>

<style scoped>

</style>