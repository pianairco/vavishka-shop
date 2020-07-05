<%@ page language="java" contentType="text/html;charset=UTF-8" %>

<div class="orbit" role="region" aria-label="Favorite Space Pictures" data-orbit data-options="animInFromLeft:fade-in; animInFromRight:fade-in; animOutToLeft:fade-out; animOutToRight:fade-out;">
    <ul class="orbit-container">
        <button class="orbit-next"><span class="show-for-sr">Previous Slide</span>&#9664;&#xFE0E;</button>
        <button class="orbit-previous"><span class="show-for-sr">Next Slide</span>&#9654;&#xFE0E;</button>
        <li class="is-active orbit-slide">
            <img class="orbit-image" src="https://placehold.it/2000x750&text=1st" alt="Space">
            <figcaption class="orbit-caption">Space, the final frontier.</figcaption>
        </li>
        <li class="orbit-slide">
            <img class="orbit-image" src="https://placehold.it/2000x750&text=2nd" alt="Space">
            <figcaption class="orbit-caption">Lets Rocket!</figcaption>
        </li>
        <li class="orbit-slide">
            <img class="orbit-image" src="https://placehold.it/2000x750&text=3nd" alt="Space">
            <figcaption class="orbit-caption">Encapsulating</figcaption>
        </li>
        <li class="orbit-slide">
            <img class="orbit-image" src="https://placehold.it/2000x750&text=4nd" alt="Space">
            <figcaption class="orbit-caption">Outta This World</figcaption>
        </li>
    </ul>
    <nav class="orbit-bullets">
        <button class="is-active" data-slide="0"><span class="show-for-sr">First slide details.</span><span class="show-for-sr">Current Slide</span></button>
        <button data-slide="1"><span class="show-for-sr">Second slide details.</span></button>
        <button data-slide="2"><span class="show-for-sr">Third slide details.</span></button>
        <button data-slide="3"><span class="show-for-sr">Fourth slide details.</span></button>
    </nav>
</div>