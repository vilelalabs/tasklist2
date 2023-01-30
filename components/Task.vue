<template>
    <div class="taskContainer">
        <button class="sel" @click="handleSelClick">
            <CheckedBox v-if="checked" />
            <UncheckedBox v-else />
        </button>

        <p class="id">{{ id }}</p>
        <p class="task">{{ name }}</p>
        <TimeCounter :state="state" />
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
        status:{
            type: String,
            required: true
        },
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
        },
        handlePlayClick() {
            this.playing = true;
            this.paused = false;
            this.stopped = false;
            this.pauseColor = 'green';
            this.state = 'playing';

            console.log("Start Time - " + this.startTime);
        },
        handlePauseClick() {
            this.pauseColor = 'grey';
            this.playing = false;
            this.paused = true;
            this.stopped = false;
            this.state = 'paused';
        },
        handleStopClick() {
            this.stopColor = 'grey';
            this.playing = false;
            this.paused = false;
            this.stopped = true;
            this.state = 'stopped';

            console.log("Finish Time - " + this.finishTime);
        },
    },
    computed: {
        startTime: function () {
            return new Date().toISOString();
        },
        finishTime: function () {
            return new Date().toISOString();
        },
    },
    mounted(){
        switch (this.status) {
            case 'playing':
                this.handlePlayClick();
                break;
            case 'paused':
                this.handlePauseClick();
                break;
            case 'stopped':
                this.handleStopClick();
                break;
            default:
                break;
        }
    }
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
    gap: 1rem;
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
</style>