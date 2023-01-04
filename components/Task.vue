<template>
    <div class="taskContainer">
        <p class="sel">
            <UncheckedBox />
        </p>
        <p class="id">id</p>
        <p class="task">Tarefa</p>
        <p class="time">00:00:00</p>
        <p class="action">
            <PlayButtonVue />
            <PauseButtonVue />
            <StopButtonVue />
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
    components: {
        UncheckedBox,
        CheckedBox,
        PlayButtonVue,
        PauseButtonVue,
        StopButtonVue,
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
    background-color: grey;
    color: #ddd;
    gap: 1rem;
    width: 100%;
    padding: 0.5rem;
    text-transform: uppercase;
    font-weight: bold;
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