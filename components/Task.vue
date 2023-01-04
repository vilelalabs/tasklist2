<template>
    <div class="taskContainer">
        <button class="sel" @click="handleSelClick">
            <CheckedBox v-if="checked" />
            <UncheckedBox v-else />
        </button>

        <p class="id">{{ id }}</p>
        <p class="task">{{ taskName }}</p>
        <p class="time">{{ time }}</p>
        <p class="action">
            <button @click="handlePlayClick" class="play">
                <PlayButtonVue  v-bind:style="{ color: playColor }" />
            </button>
            <button class="pause">
                <PauseButtonVue />
            </button>
            <button class="stop">
                <StopButtonVue />
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
    name: 'TasksTitle',
    props: {
        id: {
            type: Number,
            required: true,
        },
        taskName: {
            type: String,
            required: true,
        },
        time: {
            type: String,
            required: true,
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
            playColor: 'blue',
        }
    },
    methods: {
        handleSelClick() {
            this.checked = !this.checked;
        },
        handlePlayClick() {
            this.playColor = 'grey';
        },
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