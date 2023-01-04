<template>
    <div class="groupContainer">
        <slot></slot>
    </div>
</template>

<script>
</script>

<style scoped>
.groupContainer {
    display: flex;
    flex-direction: column;
    align-items: center;
    border-radius: 0.5rem;
    width: 100%;
    gap: 0.5rem;

    text-transform: uppercase;
    font-weight: bold;
}
</style>