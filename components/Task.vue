<template>
    <div class="taskContainer">
        <button class="sel" @click="handleSelClick">
            <CheckedBox v-if="checked" />
            <UncheckedBox v-else />
        </button>

        <p class="id">{{ id }}</p>
        <p class="task">{{ name }}</p>

        <TimeCounter @timer-output="currentTime" :state="state" :timerInSeconds="savedTime()" />

        <p class="action">
            <button v-if="!playing && !stopped" @click="handlePlayClick" class="play">
                <PlayButtonVue v-bind:style="{ color: playColor }" />
            </button>
            <button v-if="playing && !stopped" @click="handlePauseClick" class="pause">
                <PauseButtonVue v-bind:style="{ color: pauseColor }" />
            </button>
            <button v-if="playing || paused || stopped" @click="handleStopClick" class="stop">
                <StopButtonVue v-bind:style="{ color: stopColor }" />
            </button>
        </p>
    </div>
</template>

<script>
import axios from 'axios';
import UncheckedBox from '@/components/Icons/UncheckedBox.vue'
import CheckedBox from '@/components/Icons/CheckedBox.vue'
import PlayButtonVue from './Icons/PlayButton.vue';
import PauseButtonVue from './Icons/PauseButton.vue';
import StopButtonVue from './Icons/StopButton.vue';

export default {
    name: 'Task',
    props: {
        id: {
            type: Number,
            required: true,
        },
        name: {
            type: String,
            required: true,
        },
        status: {
            type: String,
            required: true
        },
        timer: {
            type: Number,
            required: true
        }
    },
    components: {
        UncheckedBox,
        CheckedBox,
        PlayButtonVue,
        PauseButtonVue,
        StopButtonVue,
    },
    data() {
        return {
            checked: false,
            playing: false,
            paused: false,
            stopped: false,
            state: 'unitialized',
            playColor: 'blue',
            pauseColor: 'blue',
            stopColor: 'red',

        }
    },
    methods: {
        handleSelClick() {
            this.checked = !this.checked;
            this.$emit('checked', true);
        },
        handlePlayClick() {
            this.setPlayState();
            this.updateStatus(this.state);
        },
        handlePauseClick() {
            this.setPauseState();
            this.updateStatus(this.state);
        },
        handleStopClick() {
            this.setStopState();
            this.updateStatus(this.state);
        },
        setPlayState() {
            this.playing = true;
            this.paused = false;
            this.stopped = false;
            this.pauseColor = 'green';
            this.state = 'playing';
        },
        setPauseState() {
            this.pauseColor = 'grey';
            this.playing = false;
            this.paused = true;
            this.stopped = false;
            this.state = 'paused';

        },
        setStopState() {
            this.stopColor = 'grey';
            this.playing = false;
            this.paused = false;
            this.stopped = true;
            this.state = 'stopped';
        },
        updateStatus(status) {
            let updatedAtDate = new Date();
            updatedAtDate = updatedAtDate.toISOString();
            axios.put(`http://${process.env.HOST_URL}/data`, {
                id: this.id,
                status: status,
                updated_at: updatedAtDate
            })
                .then((res) => {
                    console.log(res.data);
                })
                .catch((err) => {
                    console.log(err);
                });
        },
        currentTime(time) {
            axios.put(`http://${process.env.HOST_URL}/data/updatetimer`, {
                id: this.id,
                timer: time
            })
                .then((res) => {
                    //  console.log(res.data); // ALL OK
                })
                .catch((err) => {
                    console.log(err);
                });
        },
        savedTime() {
            return this.timer; //get from props
        }
    },
    computed: {
        startTime: function () {
            return new Date().toISOString();
        },
        finishTime: function () {
            return new Date().toISOString();
        },
    },
    mounted() {
        this.savedTime();
        switch (this.status) {
            case 'playing':
                this.setPlayState();
                break;
            case 'paused':
                this.setPauseState();
                break;
            case 'stopped':
                this.setStopState();
                break;
            default:
                break;
        }
    },

}
</script>

<style scoped>
.taskContainer {
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
    border-radius: 0.5rem;
    background-color: lightcyan;
    color: #444;
    gap: 1.2rem;
    width: 100%;
    padding: 0.5rem;
    text-transform: uppercase;
    font-weight: bold;
    margin-top: 0.2rem;

}

button {
    background-color: transparent;
    border: none;
    cursor: pointer;
    padding: 0;
}

.sel {
    width: 5%;
    padding-left: 0.5rem;
    text-align: center;
}

.id {
    width: 5%;
    text-align: center;
}

.task {
    width: 60%;
}

.time {
    width: 15%;
    text-align: center;
}

.action {
    width: 15%;
    text-align: center;
}


@media screen and (max-width: 480px) {
    .task {
        font-size: smaller;
    }
}

</style>