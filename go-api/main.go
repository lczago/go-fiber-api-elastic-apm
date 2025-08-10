package main

import (
	"errors"

	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/log"
	"github.com/gofiber/fiber/v2/middleware/logger"
	"go.elastic.co/apm/module/apmfiber/v2"
	"go.elastic.co/apm/v2"
)

func main() {
	fiberApp := fiber.New()

	fiberApp.Use(logger.New(logger.Config{
		Format:     "${pid} ${time} ${locals:requestid} ${status} - ${method} ${path}\n",
		TimeFormat: "2006-01-02T15:04:05.999Z",
	}))

	fiberApp.Use(apmfiber.Middleware())

	fiberApp.Get("/", func(ctx *fiber.Ctx) error {
		return ctx.SendStatus(fiber.StatusOK)
	})

	fiberApp.Get("/error", func(ctx *fiber.Ctx) error {
		err := errors.New("error test") // sending error to elastic apm
		apm.CaptureError(ctx.Context(), err).Send()
		return ctx.SendStatus(fiber.StatusInternalServerError)
	})

	if err := fiberApp.Listen(":8080"); err != nil {
		log.Fatal(err.Error())
	}
}
