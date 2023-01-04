<template>
    <div class="colorButton" :style="{ backgroundColor: color }">
        <slot>
            {{ text }}
        </slot>
    </div>
</template>

<script>
export default {
    props: {
        color: {
            type: String,
            default: '#333'
        },
        text: {
            type: String,
            default: 'Button'
        }
    }
}
</script>

<style>
.colorButton {
    color: #ddd;
    border: none;
    border-radius: 0.4rem;
    font-size: 1rem;
    padding: 0.8rem 1.6rem;
    transition: transform 0.2s ease-in-out;
}

.colorButton:hover {
    color: white;
}
</style>
