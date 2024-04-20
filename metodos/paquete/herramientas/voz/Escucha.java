package herramientas.voz;

import javax.speech.*;
import javax.speech.recognition.*;
import java.util.Locale;
import java.io.FileReader;
import java.util.concurrent.CompletableFuture;

public class Escucha extends ResultAdapter {
    private static Recognizer recognizer;
    private CompletableFuture<String> resultFuture;

    public CompletableFuture<String> arrancar() {
        try {
            recognizer = Central.createRecognizer(new EngineModeDesc(Locale.ROOT));
            recognizer.allocate();

            FileReader grammar1 = new FileReader("Gramatica.txt");

            RuleGrammar rg = recognizer.loadJSGF(grammar1);
            rg.setEnabled(true);

            recognizer.addResultListener(this);

            System.out.println("Empieze Dictado");
            recognizer.commitChanges();

            recognizer.requestFocus();
            recognizer.resume();
        } catch (Exception e) {
            System.out.println("Exception en " + e.toString());
            e.printStackTrace();
            System.exit(0);
        }

        resultFuture = new CompletableFuture<>();
        return resultFuture;
    }

    @Override
    public void resultAccepted(ResultEvent re) {
        try {
            Result res = (Result) re.getSource();
            ResultToken tokens[] = res.getBestTokens();

            if (tokens.length > 0) {
                String spokenWord = tokens[0].getSpokenText();
                resultFuture.complete(spokenWord);
            } else
                resultFuture.complete(null);

            recognizer.pause();
        } catch (Exception ex) {
            System.out.println("Ha ocurrido algo inesperado: " + ex);
            resultFuture.completeExceptionally(ex);
        }
    }
}


